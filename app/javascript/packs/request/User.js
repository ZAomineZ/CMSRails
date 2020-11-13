/**
 * @property {FormData} formData
 */
import {Fetch} from "../helper/FetchApi";

export class User {
    constructor() {
        this.formData = new FormData()
    }

    /**
     * @param {Event} event
     * @param {string} csrfValue
     */
    resAccount(event, csrfValue) {

    }

    /**
     * @param {Event} event
     * @param {string} csrfValue
     */
    async resLogout(event, csrfValue) {
        this.formData.append('authenticity_token', csrfValue)

        const uri = event.composedPath()[0].getAttribute('href')
        return await (new Fetch()).response(uri, 'POST', this.formData)
    }

}