<script>
    import Pagination from "../form/Pagination.svelte";

    // Props
    export let title = ''
    export let categories = []
</script>

<div class="card">
    <div class="card-body">
        <h5 class="card-title">{title}</h5>
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
                        <td>{category.resume}</td>
                        <td>{category.date_cat}</td>
                        <td>
                            <a href="#" class="btn btn-primary">Edit</a>
                            <a href="#" class="btn btn-danger">Delete</a>
                        </td>
                    </tr>
                {/each}
                </tbody>
            </table>
            <Pagination />
        </div>
    </div>
</div>