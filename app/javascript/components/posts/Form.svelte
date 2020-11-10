<script>
    // Modules Svelte
    import {onMount} from "svelte";

    // Libs
    import Tags from 'svelte-tags-input'
    import {Fetch} from "../../packs/helper/FetchApi";
    import InputField from "../form/InputField.svelte";
    import TextareaField from "../form/TextareaField.svelte";

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
    let image = null

    onMount(() => {
        csrfValue = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        // Mutate Data Credentials
        name = post ? post.name : name
        slug = post ? post.slug : slug
        descr = post ? post.descr : descr
    })

    // Methods

    /**
     * @param {Event} event
     */
    function onInputDescField(event) {
        descr = event.target.value
    }

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
        formData.append('image', image)

        const actionUri = event.composedPath()[0] ? event.composedPath()[0].action : ''
        const method = uriForm === '/posts' ? 'POST' : 'PUT'
        const request = await fetch.api(actionUri, method, formData)
        if (request.status === 200 || request.status === 302 || request.status === 301) {
            const response = await request.json()
            successResponse = !!response.success;
            messageResponse = response.message
        }
    }
</script>

<form action={uriForm} method="POST" on:submit|preventDefault={handleSubmit}>
    {#if uriForm === '/posts'}
        <input name="_method" type="hidden" value="put">
    {/if}
    <InputField id="name" label="Post Name" placeHolder="Enter your name..." bind:value={name}/>
    <InputField id="slug" label="Post Slug" placeHolder="Enter your slug..." bind:value={slug}/>
    <div class="form-group">
        <label for="categories">Post Categories</label>
        <Tags class="form-control" id="categories" on:tags={getTags} placeholder="Your categories..."/>
    </div>
    <TextareaField bind:value={descr} cols="30" id="descr" label="Post Content"
                   noJson={false} on:input={onInputDescField}
                   placeHolder="Enter your content"/>
    <InputField bind:value={image} className='custom-file-input' id="image" label="Choose your image" type="file"/>
    <button class="btn btn-primary mt-4" type="submit">Send</button>
</form>