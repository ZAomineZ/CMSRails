<script>
    import DeleteEntity from "./DeleteEntity.svelte";

    // PROPS
    export let entity = null
    export let entity_name = null
    export let csrfValue = null
</script>

<a class="btn btn-primary" href="/admin/{entity_name}/{entity.id}/edit">Edit</a>
<DeleteEntity csrfValue={csrfValue} uriAction="/admin/{entity_name}/{entity.id}"/>