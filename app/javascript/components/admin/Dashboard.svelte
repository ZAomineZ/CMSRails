<script>
    // MODULE SVELTE
    import {onMount} from "svelte";

    // LIB
    import {RequestDocument} from "../../packs/helper/RequestDocument";
    import {Post} from "../../packs/request/Post";

    // COMPONENT HTML
    import Header from './../layout/Header.svelte'
    import Sidebar from './../layout/Sidebar.svelte'
    import PostsTable from "./../posts/PostsTable.svelte";
    import DataDashboard from "./../concern/DataDashboard.svelte";
    import Alert from "./../concern/Alert.svelte";
    import DashboardInfo from "./concern/DashboardInfo.svelte";

    // PROPS
    export let posts = []
    export let posts_count = 0
    export let categories_count = 0
    export let pages = 1
    export let currentPage = 1
    export let messageSuccess = null
    export let messageDanger = null

    // DATA
    let csrfValue = null
    let message = null

    onMount(() => {
        csrfValue = RequestDocument.getCsrf()
    })

    /**
     * @param {Event} event
     */
    async function handlePagination(event) {
        const response = (new Post()).resPaginationData(event, csrfValue)
        if (response.success) {
            const data = response.data
            posts = data.items
            currentPage = data.current_page
        } else {
            message = response.message
        }
    }
</script>

<Sidebar />
<Header/>
<div class="container_admin">
    <div class="container_body">
        <div class="container">
            {#if messageSuccess !== null || messageDanger !== null}
                <Alert type={messageSuccess ? 'success' : 'danger'}
                       message={messageSuccess ? messageSuccess: messageDanger}/>
            {/if}
            <DashboardInfo content="Get familiar with dashboard, here are some ways to get started."
                           title="Welcome back Admin !"/>
            <div class="row">
                <div class="col-md-4">
                    <DataDashboard data_number={posts_count} title="Posts" type="warning"/>
                </div>
                <div class="col-md-4">
                    <DataDashboard data_number={categories_count} title="Categories" type="info"/>
                </div>
                <div class="col-md-4">
                    <DataDashboard data_number={10} title="Tags" type="success"/>
                </div>
            </div>
            <div class="row">
                {#if message !== null}
                    <Alert message={message} type="danger"/>
                {/if}
                <div class="col-md-12">
                    <PostsTable csrfValue={csrfValue} data={{posts, currentPage, pages}}
                                handlePagination={handlePagination} title="Last Posts"/>
                </div>
            </div>
        </div>
    </div>
</div>