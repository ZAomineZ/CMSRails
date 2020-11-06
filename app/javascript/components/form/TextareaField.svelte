<script>
    export let value = ''
    export let placeHolder = ''
    export let id = ''
    export let label = ''
    export let cols = '10'
</script>


<div class="form-group">
    <label for={id}>{label}</label>
    <textarea bind:value={value} class="form-control" cols={cols} id={id} name={id}
              placeholder={placeHolder} rows="10"></textarea>
</div>