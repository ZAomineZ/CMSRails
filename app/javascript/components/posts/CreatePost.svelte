<script>
    // Module Svelte
    import {onMount} from "svelte";

    import Sidebar from "../layout/Sidebar.svelte";
    import Header from "../layout/Header.svelte";
    import BroadCast from "../layout/navigation/BroadCast.svelte";

    // Component HTML
    import Alert from "../concern/Alert.svelte";
    import Form, {uriForm} from "./Form.svelte";

    // LIB
    import {Fetch} from "../../packs/helper/FetchApi";

    // DATA
    let successResponse = null
    let messageResponse = ''
    let csrfValue = null

    // CREDENTIALS
    let name = ''
    let slug = ''
    let categories = ''
    let descr = ''
    let files

    onMount(() => {
        csrfValue = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    })

    // Methods

    /**
     * Change value for field name
     *
     * @param {Event} event
     */
    function onInputNameField(event) {
        name = event.target.value
    }

    /**
     * Change value for field slug
     * @param {Event} event
     */
    function onInputSlugField(event) {
        slug = event.target.value
    }

    /**
     * Change value for field descr
     *
     * @param {Event} event
     */
    function onInputDescField(event) {
        descr = event.target.value
    }

    /**
     * Push categories in the data categories to STRING
     *
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
        formData.append('image', files[0])

        const actionUri = event.composedPath()[0] ? event.composedPath()[0].action : ''
        const method = uriForm === '/posts' ? 'POST' : 'PUT'
        const response = await (new Fetch()).response(actionUri, method, formData)
        successResponse = !!response.success;
        messageResponse = response.message
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
            <Form callInputs={{onInputNameField, onInputSlugField, onInputDescField}} bind:files={files}
                  on:submit={handleSubmit} on:tags={getTags}
                  uriForm="/posts"/>
        </div>
    </div>
</div>