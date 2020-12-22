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
 * Array of component instances.
 * @type {Component[]}
 */

window.components = window.components || [];

/**
 * Array of component registered.
 * @type {object[]}
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

        if(!window.components[this.id])
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
     * @param getinstance {function}
     */
    static register (tag, getinstance) {

        if(!tag)
            throw new Error("tag cannot be null");

        if(!getinstance)
            throw new Error("getinstance cannot be null");


        for(let i of window.registered) {

            if (i.tag !== tag)
                continue;

            console.debug("Skipping component, already registered: ", tag);
            return;

        }

        window.registered.push({
            tag: tag,
            getinstance: getinstance
        });

        console.debug("Registered component: ", tag);

    }


    /**
     * Render a component into his own HTML Element.
     * @param instance {Component}
     * @param data {string}
     * @param state {object}
     */
    static render(instance, data, state = {}) {

        $(instance.elem).html((instance.renderedHTML = __expandTemplate(instance.id, data, state)));

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

        for(let component of window.registered) {

            $(container).find(component.tag).each((i, v) => {

                let props = {};
                let e = $(v).get(0);

                if (e.hasAttributes()) {
                    for (let attr of e.attributes) {
                        if (attr.name.startsWith('ui:'))
                            props[attr.name.slice(3)] = attr.value;
                    }
                }


                component.getinstance(e, props);

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


        Component.render(this, this.onLoading(), {});

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

        this.__currentState = {};


        Component.render(this, this.onLoading(), {});

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

        this.__currentState = Object.assign(this.__currentState, state);

        this.onBeforeUpdate(this.state);
        Component.render(this, this.onRender(), this.state);
        this.onUpdated(this.state)

    }

    /**
     * Get current state of a dynamic UI component.
     * @returns {object}
     */
    get state() {
        return this.__currentState;
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

}




const __sanitizeSnippet = (id, snippet) => {

    return snippet
        .replace(/(")/gm, "\\\"")
        .replace(/(\r\n|\n|\r)/gm, "")
        .replace(/{{/gm, "\" + ")
        .replace(/}}/gm, " + \"");
        //.replace(/\$\$/gm, "window.components['" + id + "']");

}

const __expandTemplate = (id, template = '', data = {}) => {

    let output = '';
    let index = 0;
    let regexp = /<\?(.*?)?\?>/gs;

    output += 'let ____r = [];\n';

    let match;
    while ((match = regexp.exec(template)) !== null) {

        if(match[0] === undefined)
            break;


        output += `____r.push("${__sanitizeSnippet(id, template.substr(index, match.index - index))}");\n`;
        output += `${match[1]}\n`;

        index = regexp.lastIndex;

    }

    output += `____r.push("${__sanitizeSnippet(id, template.substr(index, template.length - index))}");\n`;
    output += 'return ____r.join("");';

    return new Function(Object.keys(data).join(", "), output)
       .apply(window.components[id], Object.values(data));

}

