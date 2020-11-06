<script>
    import Pagination from "../form/Pagination.svelte";
    import DeleteEntity from "../concern/Actions/DeleteEntity.svelte";
    import {onMount} from "svelte";

    export let title = ''
    export let posts = []
    // Data
    let csrfValue = null

    onMount(() => {
        csrfValue = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    })
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
                <tbody>
                {#each posts as post}
                    <tr>
                        <td>{post.id}</td>
                        <td>{post.name}</td>
                        <td>{post.slug}</td>
                        <td>{post.descr.slice(0, 150) + '...'}</td>
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
            <Pagination/>
        </div>
    </div>
</div>