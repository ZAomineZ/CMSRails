<script>
    export let uriAction = ''
    export let csrfValue = ''
</script>

<form action={uriAction} method="POST">
    <input type="hidden" name="_method" value="delete">
    <input type="hidden" name="authenticity_token" value={csrfValue}>
    <button type="submit" class="btn btn-danger">Delete</button>
</form>