<script>
    import Pagination from "../form/Pagination.svelte";
    import DeleteEntity from "../concern/Actions/DeleteEntity.svelte";

    export let title = ''
    export let data = {
        posts: [],
        currentPage: 1,
        pages: 1
    }
    export let handlePagination = () => {}
    export let csrfValue = null
</script>

<div class="card">
    <div class="card-body">
        <h5 class="card-title">
            {title}
            <a class="btn btn-success float-right" href="/posts/new">Create Post</a>
        </h5>
        <div class="table-responsive">
            <table class="table">
                <thead>
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Title</th>
                    <th scope="col">Slug</th>
                    <th scope="col">Content</th>
                    <th scope="col">Category</th>
                    <th scope="col">Online?</th>
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
                        <td>{post.category_id}</td>
                        <td>
                            <span class="badge badge-success">YES</span>
                        </td>
                        <td>
                            <a href="/posts/{post.id}/edit" class="btn btn-primary">Edit</a>
                            <DeleteEntity uriAction="/posts/{post.id}" csrfValue={csrfValue} />
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