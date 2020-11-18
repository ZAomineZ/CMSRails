<script>
    // MODULES SVELTE
    import {onMount} from "svelte";

    // Component HTML
    import Sidebar from "../layout/Sidebar.svelte";
    import Header from "../layout/Header.svelte";
    import BroadCast from "../layout/navigation/BroadCast.svelte";
    import Form from "./Form.svelte";
    import Alert from "../concern/Alert.svelte";

    // LIB
    import {Post} from "../../packs/request/Post";
    import {RequestDocument} from "../../packs/helper/RequestDocument";

    // Props
    export let uriForm = ''
    export let post = {}
    export let categoriesList = []
    export let dataCategories = []

    // DATA
    let successResponse = null
    let messageResponse = ''
    let csrfValue = null
    let errorFields = null

    // CREDENTIALS
    let name = null
    let slug = null
    let categories = ''
    let descr = null
    let files

    onMount(() => {
        csrfValue = RequestDocument.getCsrf()
        categories += categoriesList.join(',')
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
        const response = await (new Post()).resSubmit(event, csrfValue, {
            name: name === null ? post.name : name,
            slug: slug === null ? post.slug : slug,
            descr: descr === null ? post.descr : descr,
            categories,
            files,
            uriForm
        })
        successResponse = !!response.success;
        messageResponse = response.message
        errorFields = response.errorFields ? response.errorFields : null
    }
</script>

<Sidebar/>
<Header/>
<div class="container">
    <BroadCast
            content="Here, you can edit your post '{post.name}'."
            title="Edit Post '{post.name}'" under_links={[{
                title: 'Posts',
                link: '/admin/posts'
            }]}/>
    {#if successResponse !== null}
        <Alert type={successResponse ? 'success' : 'danger'} message={messageResponse}/>
    {/if}
    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Form to Edit Post "{post.name}"</h5>
            <p>Form post, the field name represents to title post (string between 5 and 60 characters), the field slug
                must be empty or required, the field categories represents to categories created, the field content
                represents to content post (string minimum 10 characters) and also the field file for your image attached to post.</p>
            <Form bind:files={files} callInputs={{onInputNameField, onInputSlugField, onInputDescField}}
                  categoriesList={categoriesList} on:submit={handleSubmit} on:tags={getTags} post={post}
                  dataCategories={dataCategories} errorFields={errorFields} uriForm={uriForm}/>
        </div>
    </div>
</div>