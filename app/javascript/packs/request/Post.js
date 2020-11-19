import {Fetch} from "../helper/FetchApi";

/**
 * @property {FormData} formData
 */
export class Post {
    constructor() {
        this.formData = new FormData()
    }

    /**
     * @param {Event} event
     * @param {string} csrfValue
     * @return {Promise<void>}
     */
    async resPaginationData(event, csrfValue) {
        this.formData.append('authenticity_token', csrfValue)

        const page = event.composedPath()[0].dataset ? event.composedPath()[0].dataset.page : 1
        const uriFetch = '/admin/post/pagination/' + page
        return await (new Fetch()).response(uriFetch, 'POST', this.formData)
    }

    /**
     * @param {Event} event
     * @param {string} csrfValue
     * @param {Object} data
     * @return {Promise<void>}
     */
    async resSubmit(event, csrfValue, data) {
        const {name, slug, categories, descr, files, uriForm} = data

        this.formData.append('authenticity_token', csrfValue)
        this.formData.append('name', name)
        this.formData.append('slug', slug)
        this.formData.append('categories', categories)
        this.formData.append('descr', descr)
        this.formData.append('image', files ? files[0] : null)

        const actionUri = event.composedPath()[0] ? event.composedPath()[0].action : ''
        let method
        if (uriForm || uriForm.length !== 0) {
            method = uriForm === '/admin/posts' ? 'POST' : 'PUT'
        } else {
            method = actionUri.slice(actionUri.length - 5) === 'posts' ? 'POST': 'PUT'
        }
        return await (new Fetch()).response(actionUri, method, this.formData)
    }
}