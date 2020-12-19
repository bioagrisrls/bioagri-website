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
 * UI Component type.
 */
class Component {

    /**
     * @param id {string}       DOM Element (#id or .class)
     */
    constructor(id) {

        this.id = id;

        this.onRender = this.onRender || function() { return "" };
        this.onInit   = this.onInit   || function() { return "Loading..." };
        this.onError  = this.onError  || function() { return "There was an error when creating component" };

        window.components = window.components || [];
        window.components[id] = this;

    }


    /**
     * Return HTML Element of the component
     * @returns {HTMLElement}
     */
    get elem() {
        return document.getElementById(this.id);
    }

    /**
     * Register a component and attach it to their HTML Elements.
     * @param tag {string}
     * @param getinstance {function}
     */
    static register (tag, getinstance) {

        if(!tag)
            throw new Error("tag cannot be null")

        if(!getinstance)
            throw new Error("getinstance cannot be null")


        for(let e of document.getElementsByTagName(tag))
            getinstance(e.id)

    }


    __render(data, state) {
        $(this.elem).html(__expandTemplate(this.id, data, state));
    }

}


/**
 * Static UI Component with a immutable state.
 */
class StatelessComponent extends Component {

    /**
     * @param id {string}       DOM Element (#id or .class)
     * @param state {object}    Component State
     */
    constructor(id, state) {

        super(id);
        super.__render(this.onInit(), {});


        if((state || {}).then) {
            state.then(
                (response) => this.__render(this.onRender(), response),
                (reason) => this.__render(this.onError(), {})
            );
        } else
            this.__render(this.onRender(), state || {})

    }

}

/**
 * Dynamic UI Component with a mutable state.
 */
class StatefulComponent extends Component {

    /**
     * @param id {string}       DOM Element (#id or .class)
     * @param state {object}    Component State
     */
    constructor(id, state) {

        super(id);
        super.__render(this.onInit(), {});


        this.__currentState = {};
        this.onStateChanged = this.onStateChanged || function () {};

        if((state || {}).then) {
            state.then(
                (response) => this.setState(response),
                (reason) => this.__render(this.onError(), {})
            );
        } else
            this.setState(state || {});


    }

    /**
     * Change state of component and redraw it.
     * @param state {object}
     */
    setState(state) {

        this.__currentState = Object.assign(this.__currentState, state);
        this.onStateChanged(this.__currentState);
        this.__render(this.onRender(), this.__currentState);

    }

    /**
     * Get current state of a dynamic UI component.
     * @returns {object}
     */
    get state() {
        return this.__currentState;
    }

}




const __sanitizeSnippet = (id, snippet) => {

    return snippet
        .replace(/(")/gm, "\\\"")
        .replace(/(\r\n|\n|\r)/gm, "")
        .replace(/{{/gm, "\" + ")
        .replace(/}}/gm, " + \"")
        .replace(/\$\$/gm, "window.components['" + id + "']");

}

const __expandTemplate = (id, template = '', data = {}) => {

    let output = '';
    let index = 0;
    let regexp = /<\?(.*?)?\?>/gms;


    output += 'let ____r = [];\n';

    let match;
    while ((match = regexp.exec(template)) !== null) {

        if(match[0] === undefined)
            break;


        output += `____r.push("${__sanitizeSnippet(id, template.slice(index, match.index))}");\n`;
        output += `${match[1]}\n`;

        index = regexp.lastIndex;

    }

    output += `____r.push("${__sanitizeSnippet(id, template.slice(index, template.length - index))}");\n`;
    output += 'return ____r.join("");';


    return new Function(Object.keys(data).join(", "), output)
       .apply(null, Object.values(data));

}
