<script>
    export let value = ''
    export let valueText = ''
    export let placeHolder = ''
    export let id = ''
    export let label = ''
    export let cols = '10'
    export let noJson = true
    export let error = null
</script>

<div class="form-group">
    <label for={id}>{label}</label>
    {#if noJson}
        <textarea class={error ? 'form-control is-invalid' : 'form-control'} cols={cols} id={id} name={id}
                  placeholder={placeHolder}
                  rows="10">{valueText}</textarea>
    {:else}
        <textarea on:input class={error ? 'form-control is-invalid' : 'form-control'} cols={cols} id={id} name={id}
                  placeholder={placeHolder}
                  rows="10">{valueText}</textarea>
    {/if}
    {#if error}
        <div class="invalid-feedback">
            The Field {id} {error.join(', ')}
        </div>
    {/if}

</div>