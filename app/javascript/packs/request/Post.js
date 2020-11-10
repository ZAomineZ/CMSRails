import {Fetch} from "../helper/FetchApi";

export class Post
{
    /**
     * @param {Event} event
     * @param {string} csrfValue
     * @return {Promise<void>}
     */
    async resPaginationData(event, csrfValue)
    {
        let formData = new FormData()
        formData.append('authenticity_token', csrfValue)

        const page = event.composedPath()[0].dataset ? event.composedPath()[0].dataset.page : 1
        const uriFetch = '/posts/pagination/' + page
        return await (new Fetch()).response(uriFetch, 'POST', formData)
    }
}