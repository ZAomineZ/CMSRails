<script>
    import Pagination from "../form/Pagination.svelte";
    import DeleteEntity from "../concern/Actions/DeleteEntity.svelte";

    export let title = ''
    export let data = {
        categories: [],
        currentPage: 1,
        pages: 1
    }
    export let message = null
    export let handlePagination = () => {}
    export let csrfValue = ''
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
                {#each data.categories as category}
                    <tr>
                        <td>{category.id}</td>
                        <td>{category.name}</td>
                        <td>{category.slug}</td>
                        <td>{category.resume.length >= 150 ? category.resume.slice(0, 150) + '...' : category.resume}</td>
                        <td>{category.date_cat}</td>
                        <td>
                            <a href="/category/{category.id}/edit" class="btn btn-primary">Edit</a>
                            <DeleteEntity uriAction="/category/{category.id}" csrfValue={csrfValue} />
                        </td>
                    </tr>
                {/each}
                </tbody>
            </table>
            {#if data.pages !== 1}
                <Pagination pages={data.pages} currentPage={data.currentPage} on:click={handlePagination} />
            {/if}
        </div>
    </div>
</div>