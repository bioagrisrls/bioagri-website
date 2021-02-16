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



function editTagModal() {

    $('#editTagModal').on('show.bs.modal', function(event) {

        var button = $(event.relatedTarget) // Button that triggered the modal
        var id = button.data('whatever') //
        var modal = $(this)
        modal.find('.modal-title').text('id :' + id)
        modal.find('modal-recipient').val(id)
        $('#deleteTagButton').val(id)
        $('#updateTagButton').val(id);

    })

}

function editCategorymodal() {

    $('#editCategoryModal').on('show.bs.modal', function(event) {

        var button = $(event.relatedTarget) // Button that triggered the modal
        var id = button.data('whatever') //
        var modal = $(this)
        modal.find('.modal-title').text('id :' + id)
        modal.find('modal-recipient').val(id)
        $('#deleteCategoryButton').val(id)
        $('#updateCategoryButton').val(id);

    })

}

function updateTag() {

    const http = new XMLHttpRequest();
    id = $('#updateTagButton').val();
    name = $('#nameTagForm').val();
    http.open('POST', '/admin/update/tag', true);
    http.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    http.send("id=" + id + "&hashtag=#" + name);
    location.reload();


}


function updateCategory() {

    console.log("category uopdate")
    const http = new XMLHttpRequest();
    id = $('#updateButton').val();
    name = $('#nameCategoryForm').val();
    http.open('POST', '/admin/update/category', true);
    http.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    http.send("id=" + id + "&name=" + name);
    location.reload();


}

function createCategory() {
    const http = new XMLHttpRequest();
    http.open('POST', '/admin/create/category', true);
    http.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    http.send("name=" + document.getElementById("category").value);
    location.reload();
}

function createTag() {

    const http = new XMLHttpRequest();
    http.open('POST', '/admin/create/tag', true);
    http.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    http.send("hashtag=#" + document.getElementById("tag").value);
    location.reload();

}

function deleteCategory(category) {

    if (confirm("Sei sicuro di voler eliminare questo elemento?")) {
        const http = new XMLHttpRequest();
        http.open('POST', '/admin/delete/category', true);
        http.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        http.send("id=" + category.value);
        location.reload();
    }

}


function deleteTag(tag) {

    if (confirm("Sei sicuro di voler eliminare questo elemento?")) {
        const http = new XMLHttpRequest();
        http.open('POST', '/admin/delete/tag', true);
        http.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
        http.send("id=" + tag.value);
        location.reload();
    }

}