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

    // PROPS
    export let posts = []
    export let posts_count = 0
    export let categories_count = 0
    export let pages = 1
    export let currentPage = 1

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
            <div class="row">
                <div class="col-md-12">
                    <div class="card bg-info text-white">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6 info-container-text">
                                    <h5 class="card-title">Welcome back Admin !</h5>
                                    <p>Get familiar with dashboard, here are some ways to get started.</p>
                                    <ul>
                                        <li>Todo 1</li>
                                        <li>Todo 2</li>
                                        <li>Todo 3</li>
                                    </ul>
                                </div>
                                <div class="col-md-6 info-container-image"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4">
                    <DataDashboard data_number={posts_count} title="New Posts" type="warning"/>
                </div>
                <div class="col-md-4">
                    <DataDashboard data_number={categories_count} title="New Categories" type="info"/>
                </div>
                <div class="col-md-4">
                    <DataDashboard data_number={10} title="New Tags" type="success"/>
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