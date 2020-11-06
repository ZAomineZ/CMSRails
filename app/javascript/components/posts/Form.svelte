<script>
    // Modules Svelte
    import {onMount} from "svelte";

    // Libs
    import Tags from 'svelte-tags-input'
    import {Fetch} from "../../packs/helper/FetchApi";

    // Props
    export let uriForm = ''
    export let post = null
    export let successResponse = null
    export let messageResponse = ''

    // Data
    let csrfValue = null
    let fetch = new Fetch()

    // Data Credentials
    let name = ''
    let slug = ''
    let categories = ''
    let descr = ''

    onMount(() => {
        csrfValue = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    })

    // Methods

    /**
     * @param {Event} event
     */
    function getTags(event) {
        let data = event.detail.tags
        categories = data.join(',')
    }

    /**
     * Method submit form for action create post
     *
     * @param {Event} event
     */
    async function handleSubmit(event) {
        let formData = new FormData()
        formData.append('authenticity_token', csrfValue)
        formData.append('name', name)
        formData.append('slug', slug)
        formData.append('categories', categories)
        formData.append('descr', descr)

        const actionUri = event.composedPath()[0] ? event.composedPath()[0].action : ''
        const method = uriForm === '/posts/create' ? 'POST': 'PUT'
        const request = await fetch.api(actionUri, method, formData)
        if (request.status === 200 || request.status === 302 || request.status === 301) {
            const response = await request.json()
            successResponse = !!response.success;
            messageResponse = response.message
        }
    }
</script>

<form action={uriForm} method="POST" on:submit|preventDefault={handleSubmit}>
    {#if uriForm !== '/posts/create'}
        <input name="_method" type="hidden" value="put">
    {/if}
    <div class="form-group">
        <label for="name">Post Name</label>
        <input class="form-control" id="name" name="name" placeholder="Enter your name..." type="text"
               value={post ? post.name : ''}>
    </div>
    <div class="form-group">
        <label for="slug">Post Slug</label>
        <input class="form-control" id="slug" name="slug" placeholder="Enter your slug..." type="text"
               value={post ? post.slug : ''}>
    </div>
    <div class="form-group">
        <label for="categories">Post Categories</label>
        <Tags class="form-control" id="categories" value={post ? post.category_id: ''} on:tags={getTags} placeholder="Your categories..."/>
    </div>
    <div class="form-group">
        <label for="descr">Post Content</label>
        <textarea class="form-control" cols="30" id="descr" name="descr" placeholder="Your content..."
                  rows="10">{post ? post.descr : ''}</textarea>
    </div>
    <button class="btn btn-primary" type="submit">Send</button>
</form>