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
            content="Here, you can create a new category."
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
            <p>Form category, the field name represents to name category (string between 5 and 60 characters), the field slug
                must be empty or required, the field content represents to content post (string minimum 10 characters)
                and also the field file for your image attached to category.</p>
            <Form uriForm={uriForm} errorFields={errorFields}/>
        </div>
    </div>
</div>