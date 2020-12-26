"use strict";

/*
 * MIT License
 *
 * Copyright (c) 2020 BioAgri S.r.l.s.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 *
 */



/**
 * Collection of component instances.
 * @type {Component[]}
 */
window.components = window.components || [];

/**
 * Collection of registered components.
 * @type {function}
 */
window.registered = window.registered || [];



/**
 * Load registered components when DOM is ready.
 */
$(document).ready(() => {
    Component.run(document);
});





/**
 * UI Component type.
 */
class Component {

    /**
     * @param elem {HTMLElement}       HTML Element
     */
    constructor(elem) {

        this.elem = elem;
        this.id = `${elem.id}`;
        this.innerHTML = `${elem.innerHTML}`;
        this.renderedHTML = '';

        window.components[this.id] = this;

    }

    /**
     * Render a template string into HTML Element each state update.
     * @returns {string}
     */
    onRender() {
        return "";
    }

    /**
     * Render a template string into HTML Element before loading state.
     * @returns {string}
     */
    onLoading() {
        return "Loading...";
    }

    /**
     * Render a template string into HTML Element on loading failure.
     * @returns {string}
     */
    onError() {
        return "There was an error when loading component";
    }

    /**
     * Initialize component's event.
     */
    onInit() {

    }



    /**
     * Register a component and attach it to their HTML Elements.
     * @param tag {string}
     * @param getInstance {function}
     */
    static register (tag, getInstance) {

        if(!tag)
            throw new Error("tag cannot be null");

        if(!getInstance)
            throw new Error("getinstance cannot be null");


        window.registered[tag] = getInstance;

        console.debug("Registered component: ", tag);

    }


    /**
     * Render a component into his own HTML Element.
     * @param instance {Component}
     * @param template {string}
     * @param state {object}
     */
    static render(instance, template, state = {}) {

        $(instance.elem).html((instance.renderedHTML = $renderTemplate(instance, template, state)));

        const recursive_render = (elem) => {
            for(let el of elem.children) {

                if(window.components[el.id])
                    $(el).html(window.components[el.id].renderedHTML);
                else
                    recursive_render(el);

            }
        };

        recursive_render(instance.elem);

    }


    /**
     * Initialize and load registered components into a DOM container
     * @param container {string | HTMLElement | Document}
     */
    static run(container) {

        for(let component of Object.keys(window.registered)) {

            $(container).find(component).each((i, v) => {

                let props = {};
                let e = $(v).get(0);

                if (e.hasAttributes()) {
                    for (let attr of e.attributes) {
                        if (attr.name.startsWith('ui:'))
                            props[attr.name.slice(3)] = attr.value || true;
                    }
                }

                console.log(e);
                window.registered[component](e, props);

                console.debug("Loading component: ", window.components[e.id].id);

            });

        }

    }


}


/**
 * Static UI Component with a immutable state.
 */
class StatelessComponent extends Component {

    /**
     * @param elem {HTMLElement}    HTML Element
     * @param state {object}        Component State
     */
    constructor(elem, state) {

        super(elem);
        this.onInit();


        Component.render(this, this.onLoading(), state || {});

        if((state || {}).then) {
            state.then(
                (response) => Component.render(this, this.onRender(), response),
                (reason) => Component.render(this, this.onError(), {})
            );
        } else {
            Component.render(this, this.onRender(), state || {})
        }

    }

}

/**
 * Dynamic UI Component with a mutable state.
 */
class StatefulComponent extends Component {

    /**
     * @param elem {HTMLElement}    HTML Element
     * @param state {object}        Component State
     */
    constructor(elem, state) {

        super(elem);
        this.onInit();

        this.$currentState = {};
        this.$isReady = false;


        Component.render(this, this.onLoading(), state || {});

        if((state || {}).then) {
            state.then(
                (response) => this.setState(response),
                (reason) => Component.render(this, this.onError(), {})
            )
        } else {
            this.setState(state || {});
        }

    }

    /**
     * Change state of component and redraw it.
     * @param state {object}
     */
    setState(state) {

        this.$currentState = Object.assign(this.$currentState, state);


        if(!this.$isReady) {
            this.$isReady = true;
            this.onReady(this.state);
        }

        this.onBeforeUpdate(this.state);
        Component.render(this, this.onRender(), this.state);
        this.onUpdated(this.state)

    }

    /**
     * Get current state of a dynamic UI component.
     * @returns {object}
     */
    get state() {
        return this.$currentState;
    }

    /**
     * Change state of component and redraw it.
     * @param state {object}
     * @see setState
     */
    set state(state) {
        this.setState(state);
    }


    /**
     * Before redraw of a component.
     * @param state {object}
     */
    onBeforeUpdate(state) {

    }

    /**
     * After redraw of a component.
     * @param state {object}
     */
    onUpdated(state) {

    }

    /**
     * When a first state is available
     * @param state {object}
     */
    onReady(state) {

    }

}


/**
 * Render a template string in HTML.
 * @param instance {Component}
 * @param template {string}
 * @param state {object}
 * @returns {string}
 */
const $renderTemplate = (instance, template = '', state = {}) => {

    /**
     * @param id {string}
     * @param snippet {string}
     * @returns {string}
     */
    const sanitize = (id, snippet) => {
        return snippet
            .replace(/(")/gm, "\\\"")
            .replace(/(\r\n|\n|\r)/gm, "")
            .replace(/{{/gm, "\" + (")
            .replace(/}}/gm, ") + \"")
            .replace(/\$\$/gm, "window.components['" + id + "']");
    }


    let index = 0;
    let output = '';
    let regexp = /<\?(.*?)?\?>/gs;


    output += 'let $$$$ = [];\n';

    let match;
    while ((match = regexp.exec(template))) {

        if(match[0] === undefined)
            break;


        output += `$$$$.push("${sanitize(instance.id, template.substr(index, match.index - index))}");\n`;
        output += `${match[1]}\n`;

        index = regexp.lastIndex;

    }

    output += `$$$$.push("${sanitize(instance.id, template.substr(index, template.length - index))}");\n`;
    output += 'return $$$$.join("");';

    return new Function(Object.keys(state).join(", "), output)
       .apply(instance, Object.values(state));

}

