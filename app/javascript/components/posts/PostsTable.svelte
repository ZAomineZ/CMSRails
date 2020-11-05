<script>
    import Pagination from "../form/Pagination.svelte";

    export let title = ''
</script>

<div class="card">
    <div class="card-body">
        <h5 class="card-title">{title}</h5>
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
                    <tr>
                        <td>1</td>
                        <td>Post Title</td>
                        <td>Slug Post</td>
                        <td>Content Post</td>
                        <td>Category Post</td>
                        <td>
                            <span class="badge badge-success">YES</span>
                        </td>
                        <td>
                            <a href="#" class="btn btn-primary">Edit</a>
                            <a href="#" class="btn btn-danger">Delete</a>
                        </td>
                    </tr>
                </tbody>
            </table>
            <Pagination />
        </div>
    </div>
</div>