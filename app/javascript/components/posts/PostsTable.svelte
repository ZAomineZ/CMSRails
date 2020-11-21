<script>
    // MODULES SVELTE
    import {onMount} from "svelte";
    // MODULES HTML
    import Pagination from "../form/Pagination.svelte";
    import ActionTable from "../concern/Actions/ActionTable.svelte";

    export let title = ''
    export let data = {
        posts: [],
        currentPage: 1,
        pages: 1
    }
    export let handlePagination = () => {
    }
    export let csrfValue = null

    onMount(() => {
    })
</script>

<div class="card">
    <div class="card-body">
        <h5 class="card-title">
            {title}
            <a class="btn btn-success float-right" href="/admin/posts/new">Create Post</a>
        </h5>
        <div class="table-responsive">
            <table class="table">
                <thead>
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Title</th>
                    <th scope="col">Slug</th>
                    <th scope="col">Content</th>
                    <th scope="col">Actions</th>
                </tr>
                </thead>
                <tbody id="tbody-posts">
                {#each data.posts as post}
                    <tr>
                        <td>{post.id}</td>
                        <td>{post.name}</td>
                        <td>{post.slug}</td>
                        <td>{post.descr.length >= 150 ? post.descr.slice(0, 150) + '...' : post.descr}</td>
                        <td>
                            <ActionTable entity={post} csrfValue={csrfValue} entity_name="posts"/>
                        </td>
                    </tr>
                {/each}
                </tbody>
            </table>
            {#if data.pages !== 1}
                <Pagination pages={data.pages} currentPage={data.currentPage} on:click={handlePagination}/>
            {/if}
        </div>
    </div>
</div>