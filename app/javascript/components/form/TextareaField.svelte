<script>
    export let value = ''
    export let valueText = ''
    export let placeHolder = ''
    export let id = ''
    export let label = ''
    export let cols = '10'
    export let noJson = true
</script>

<div class="form-group">
    <label for={id}>{label}</label>
    {#if noJson}
        <textarea class="form-control" cols={cols} id={id} name={id} placeholder={placeHolder}
                  rows="10">{valueText}</textarea>
    {:else}
        <textarea on:input class="form-control" cols={cols} id={id} name={id} placeholder={placeHolder}
                  rows="10">{valueText}</textarea>
    {/if}

</div>