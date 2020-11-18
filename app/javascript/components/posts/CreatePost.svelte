<script>
    // Module Svelte
    import {onMount} from "svelte";

    import Sidebar from "../layout/Sidebar.svelte";
    import Header from "../layout/Header.svelte";
    import BroadCast from "../layout/navigation/BroadCast.svelte";

    // Component HTML
    import Alert from "../concern/Alert.svelte";
    import Form from "./Form.svelte";

    // LIB
    import {Post} from "../../packs/request/Post";
    import {RequestDocument} from "../../packs/helper/RequestDocument";

    // PROPS
    export let uriForm = ''
    export let dataCategories = []

    // DATA
    let successResponse = null
    let messageResponse = ''
    let csrfValue = null
    let errorFields = null

    // CREDENTIALS
    let name = ''
    let slug = ''
    let categories = ''
    let descr = ''
    let files

    onMount(() => {
        csrfValue = RequestDocument.getCsrf()
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
     * Push category in the data category to STRING
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
        const response = await (new Post()).resSubmit(event, csrfValue, {name, slug, descr, categories, files, uriForm})
        successResponse = !!response.success;
        messageResponse = response.message
        errorFields = response.errorFields ? response.errorFields : null
    }
</script>

<Sidebar/>
<Header/>
<div class="container">
    <BroadCast
            content="Here, you can create a new post, this new post can be linked by your categories, you can also add a new image to this post."
            title="Create Post" under_links={[{
                title: 'Posts',
                link: '/admin/post'
            }]}/>
    {#if successResponse !== null}
        <Alert type={successResponse ? 'success' : 'danger'} message={messageResponse}/>
    {/if}
    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Form to Create Post</h5>
            <p>Form post, the field name represents to title post (string between 5 and 60 characters), the field slug
                must be empty or required, the field categories represents to categories created, the field content
                represents to content post (string minimum 10 characters) and also the field file for your image attached to post.</p>
            <Form callInputs={{onInputNameField, onInputSlugField, onInputDescField}} bind:files={files}
                  on:submit={handleSubmit} on:tags={getTags}
                  dataCategories={dataCategories} errorFields={errorFields} uriForm="/admin/posts"/>
        </div>
    </div>
</div>