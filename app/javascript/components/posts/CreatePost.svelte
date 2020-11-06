<script>
    import Sidebar from "../layout/Sidebar.svelte";
    import Header from "../layout/Header.svelte";
    import BroadCast from "../layout/navigation/BroadCast.svelte";

    // Modules Helper
    import {Fetch} from '../../packs/helper/FetchApi'
    // Libs
    import Tags from 'svelte-tags-input'
    import {onMount} from "svelte";
    import Alert from "../concern/Alert.svelte";

    // Data
    let csrfValue = null
    let successResponse = null
    let messageResponse = ''
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
        const request = await fetch.api(actionUri, 'POST', formData)
        if (request.status === 200 || request.status === 302 || request.status === 301) {
            const response = await request.json()
            successResponse = !!response.success;
            messageResponse = response.message
        }
    }
</script>

<Sidebar/>
<Header/>
<div class="container">
    <BroadCast
            content="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquid aspernatur consequuntur distinctio, dolore ex fugit illum in modi necessitatibus nisi non, odio rerum, soluta unde ut? Cumque rem sequi voluptates."
            title="Create Post"/>
    {#if successResponse !== null}
        <Alert type={successResponse ? 'success' : 'danger'} message={messageResponse}/>
    {/if}
    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Form to Create Post</h5>
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Distinctio eos hic illum ipsam molestiae,
                mollitia porro quibusdam reiciendis rem suscipit vel vero? Exercitationem fugit illo iure libero natus
                ratione recusandae.</p>
            <form action="/posts" method="POST" on:submit|preventDefault={handleSubmit}>
                <div class="form-group">
                    <label for="title">Post Title</label>
                    <input bind:value={name} class="form-control" id="title" placeholder="Enter your title..."
                           type="text">
                </div>
                <div class="form-group">
                    <label for="slug">Post Title</label>
                    <input bind:value={slug} class="form-control" id="slug" placeholder="Enter your title..."
                           type="text">
                </div>
                <div class="form-group">
                    <label for="categories">Post Categories</label>
                    <Tags class="form-control" id="categories" on:tags={getTags} placeholder="Your categories..."/>
                </div>
                <div class="form-group">
                    <label for="descr">Post Content</label>
                    <textarea bind:value={descr} class="form-control" cols="30" id="descr" placeholder="Your content..."
                              rows="10"></textarea>
                </div>
                <button class="btn btn-primary" type="submit">Envoyer</button>
            </form>
        </div>
    </div>
</div>