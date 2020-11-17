<script>
    import DeleteEntity from "./DeleteEntity.svelte";

    // PROPS
    export let entity = null
    export let csrfValue = null
</script>

<a class="btn btn-primary" href="/admin/category/{entity.id}/edit">Edit</a>
<DeleteEntity csrfValue={csrfValue} uriAction="/admin/category/{entity.id}"/>