<script>
    // MODULES SVELTE
    import {onMount} from "svelte";

    // COMPONENT HTML
    import Header from "../layout/Header.svelte";
    import Sidebar from "../layout/Sidebar.svelte";
    import PostsTable from "./PostsTable.svelte";
    import Alert from "../concern/Alert.svelte";

    // LIB
    import {Fetch} from "../../packs/helper/FetchApi";
    import {RequestDocument} from "../../packs/helper/RequestDocument";

    // Props
    export let posts = []
    export let pages = 1
    export let currentPage = 1

    // Data
    let csrfValue = null
    let message = null

    onMount(() => {
        csrfValue = RequestDocument.getCsrf()
    })

    // Methods

    /**
     * @param {Event} event
     */
    async function handlePagination(event) {
        let formData = new FormData()
        formData.append('authenticity_token', csrfValue)

        const page = event.composedPath()[0].dataset ? event.composedPath()[0].dataset.page : 1
        const uriFetch = '/posts/pagination/' + page
        const response = await (new Fetch()).response(uriFetch, 'POST', formData)
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
<Header />
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="title-page-contain">
                <nav>
                    <ol class="navigation">
                        <li class="navigation-item">
                            <a href="#">Home</a>
                        </li>
                        <li class="navigation-item active">
                            <i class="fas fa-chevron-right icon-navigation-item icon-navigation-item-m"></i>
                            Posts
                        </li>
                    </ol>
                </nav>
                <h3>Posts</h3>
                <p class="desc-page-contain">
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ad esse minus quasi sequi! Culpa,
                    distinctio dolore eum id, in ipsam iure nulla obcaecati odit repellat rerum sint soluta totam
                    voluptates!
                </p>
            </div>
            {#if message !== null}
                <Alert message={message} type="danger"/>
            {/if}
        </div>
    </div>
    <PostsTable data={{posts, currentPage, pages}} handlePagination={handlePagination} title="Posts List"/>
</div>