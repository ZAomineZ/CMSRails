<script>
    import Sidebar from "../layout/Sidebar.svelte";
    import Header from "../layout/Header.svelte";
    import BroadCast from "../layout/navigation/BroadCast.svelte";
    import Form from "../category/Form.svelte";
    import Alert from "../concern/Alert.svelte";

    // Modules Svelte
    import {onMount} from 'svelte'

    // Props
    export let uriForm = ''
    export let errorFields = []
    export let messageSuccess = null
    export let messageError = null

    // Data
    let csrfValue = null

    onMount(() => {
        csrfValue = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    })
</script>

<Sidebar/>
<Header/>
<div class="container">
    <BroadCast
            content="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Aliquid aspernatur consequuntur distinctio, dolore ex fugit illum in modi necessitatibus nisi non, odio rerum, soluta unde ut? Cumque rem sequi voluptates."
            title="Create Category" under_links={[{
                title: 'Categories',
                link: '/admin/category'
            }]}/>
    {#if messageSuccess !== null || messageError !== null}
        <Alert type={messageSuccess ? 'success' : 'danger'} message={messageSuccess ? messageSuccess: messageError}/>
    {/if}
    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Form to Create Category</h5>
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Distinctio eos hic illum ipsam molestiae,
                mollitia porro quibusdam reiciendis rem suscipit vel vero? Exercitationem fugit illo iure libero natus
                ratione recusandae.</p>
            <Form uriForm={uriForm} errorFields={errorFields}/>
        </div>
    </div>
</div>