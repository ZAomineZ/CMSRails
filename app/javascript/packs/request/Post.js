import {Fetch} from "../helper/FetchApi";
import {uriForm} from "../../components/posts/Form.svelte";

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
        const uriFetch = '/posts/pagination/' + page
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
        this.formData.append('image', files[0])

        const actionUri = event.composedPath()[0] ? event.composedPath()[0].action : ''
        const method = uriForm === '/posts' ? 'POST' : 'PUT'
        return  await (new Fetch()).response(actionUri, method, this.formData)
    }
}