<script>
    // Modules Svelte
    import {onMount} from 'svelte'

    import Header from "../layout/Header.svelte";
    import Sidebar from "../layout/Sidebar.svelte";
    import CategoriesTable from "./CategoriesTable.svelte";
    import BroadCast from "../layout/navigation/BroadCast.svelte";

    import {Fetch} from "../../packs/helper/FetchApi";
    import Alert from "../concern/Alert.svelte";

    // Props
    export let categories = []
    export let pages = 1
    export let currentPage = 1
    export let messageSuccess = null
    export let messageError = null

    // Data
    let csrfValue = null
    let message = null

    onMount(() => {
        csrfValue = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    })

    /**
     * @param {Event} event
     */
    async function handlePagination(event) {
        let formData = new FormData()
        formData.append('authenticity_token', csrfValue)

        const page = event.composedPath()[0].dataset ? event.composedPath()[0].dataset.page : 1
        const uriFetch = '/admin/category/pagination/' + page
        const response = await (new Fetch()).response(uriFetch, 'POST', formData)
        if (response.success) {
            const data = response.data
            categories = data.items
            currentPage = data.current_page
        } else {
            message = response.message
        }
    }
</script>

<Sidebar/>
<Header/>
<div class="container">
    <BroadCast
            content="Here, you can see the listening to categories than you have create, you can also edit or delete the different categories."
            title="Categories"/>
    {#if message !== null}
        <Alert message={message} type="danger"/>
    {/if}
    {#if messageSuccess !== null || messageError !== null}
        <Alert type={messageSuccess ? 'success' : 'danger'} message={messageSuccess ? messageSuccess: messageError}/>
    {/if}
    <CategoriesTable csrfValue={csrfValue} data={{categories, currentPage, pages}} handlePagination={handlePagination}
                     message={message} title="Categories List"/>
</div>