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



const sanitizeSnippet = (snippet) => {

    return snippet
        .replace(/(")/gm, "\\\"")
        .replace(/(\r\n|\n|\r)/gm, "")
        .replace(/{{/g, "\" + ")
        .replace(/}}/g, " + \"");

}

const expandTemplate = (template = '', data = {}) => {

    let output = '';
    let index = 0;
    let regexp = /<\?([^?>]+)?\?>/g;


    output += 'let ____r = [];\n';

    let match;
    while ((match = regexp.exec(template)) !== null) {

        if(match[0] === undefined)
            break;


        output += `____r.push("${sanitizeSnippet(template.slice(index, match.index))}");\n`;
        output += `${match[1]}\n`;

        index = regexp.lastIndex;

    }

    output += `____r.push("${sanitizeSnippet(template.slice(index, template.length - index))}");\n`;
    output += 'return ____r.join("");';


    return new Function(Object.keys(data).join(", "), output)
        .apply(null, Object.values(data));

}


const render = (id, component) => {

    if(!component.template)
        throw new Error('template cannot be null');

    if($(id).length === 0)
        throw new Error(`invalid id/class reference: ${id}`);

    $(id).html(component.init || 'Loading...');


    if(component.data.then) {

        component.data.then(data => {
            $(id).html(expandTemplate(component.template, data));
        })

    } else {

        $(id).html(expandTemplate(component.template, component.data));

    }
}