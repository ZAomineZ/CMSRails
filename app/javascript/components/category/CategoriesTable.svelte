<script>
    import Pagination from "../form/Pagination.svelte";
    import {onMount} from "svelte";

    // Props
    export let title = ''
    export let categories = []
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
            <a href="/category/new" class="btn btn-success float-right">Create Category</a>
        </h5>
        <div class="table-responsive">
            <table class="table">
                <thead>
                <tr>
                    <th scope="col">ID</th>
                    <th scope="col">Name</th>
                    <th scope="col">Slug</th>
                    <th scope="col">Content</th>
                    <th scope="col">Date</th>
                    <th scope="col">Actions</th>
                </tr>
                </thead>
                <tbody>
                {#each categories as category}
                    <tr>
                        <td>{category.id}</td>
                        <td>{category.name}</td>
                        <td>{category.slug}</td>
                        <td>{category.resume.slice(0, 150) + '...'}</td>
                        <td>{category.date_cat}</td>
                        <td>
                            <a href="/category/{category.id}/edit" class="btn btn-primary">Edit</a>
                            <form action="/category/{category.id}" method="POST">
                                <input type="hidden" name="_method" value="delete">
                                <input type="hidden" name="authenticity_token" value={csrfValue}>
                                <button type="submit" class="btn btn-danger">Delete</button>
                            </form>
                        </td>
                    </tr>
                {/each}
                </tbody>
            </table>
            <Pagination />
        </div>
    </div>
</div>