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
        const response = (new Post()).resSubmit(event, csrfValue, {name, slug, descr, categories, files, uriForm})
        successResponse = !!response.success;
        messageResponse = response.message
    }
</script>

<Sidebar/>
<Header/>
<div class="container">
    <BroadCast
            content="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquid aspernatur consequuntur distinctio, dolore ex fugit illum in modi necessitatibus nisi non, odio rerum, soluta unde ut? Cumque rem sequi voluptates."
            title="Edit Post '{post.name}' "/>
    {#if successResponse !== null}
        <Alert type={successResponse ? 'success' : 'danger'} message={messageResponse}/>
    {/if}
    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Form to Edit Post "{post.name}"</h5>
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Distinctio eos hic illum ipsam molestiae,
                mollitia porro quibusdam reiciendis rem suscipit vel vero? Exercitationem fugit illo iure libero natus
                ratione recusandae.</p>
            <Form bind:files={files} callInputs={{onInputNameField, onInputSlugField, onInputDescField}}
                  on:submit={handleSubmit} on:tags={getTags} post={post}
                  uriForm={uriForm}/>
        </div>
    </div>
</div>