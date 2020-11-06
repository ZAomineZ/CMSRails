<script>
    export let value = ''
    export let placeHolder = ''
    export let id = ''
    export let label = ''
</script>


<div class="form-group">
    <label for={id}>{label}</label>
    <input bind:value={value} class="form-control" id={id} name={id} placeholder={placeHolder} type="text"/>
</div>