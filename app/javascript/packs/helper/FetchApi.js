export class Fetch
{
    /**
     * @param {string} uri
     * @param {string} method
     * @param {FormData} formData
     * @returns {Promise<Response>}
     */
    async api(uri, method = 'POST', formData) {
        return fetch(uri, {
            method,
            body: formData,
            headers: {'X-Requested-With': 'XMLHttpRequest'}
        })
    }
}