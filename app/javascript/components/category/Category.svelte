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
        const uriFetch = '/categories/pagination/' + page
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
            content="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ad esse minus quasi sequi! Culpa, distinctio dolore eum id, in ipsam iure nulla obcaecati odit repellat rerum sint soluta totam voluptates!"
            title="Categories"/>
    {#if message !== null}
        <Alert message={message} type="danger"/>
    {/if}
    <CategoriesTable csrfValue={csrfValue} data={{categories, currentPage, pages}} handlePaggination={handlePagination}
                     message={message} title="Categories List"/>
</div>