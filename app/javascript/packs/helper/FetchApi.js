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

    /**
     * @param uriFetch
     * @param method
     * @param formData
     * @returns {Promise<any>|null}
     */
    async response(uriFetch, method = 'POST', formData)
    {
        const request = await this.api(uriFetch, 'POST', formData)
        if (request.status === 200 || request.status === 301 || request.status === 302) {
            return await request.json()
        }
        return null
    }
}