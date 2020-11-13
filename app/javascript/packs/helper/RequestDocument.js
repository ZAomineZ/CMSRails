export class RequestDocument
{
    /**
     * @return {string}
     */
    static getCsrf()
    {
        return document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    }
}