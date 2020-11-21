<script>
    export let value = ''
    export let files
    export let placeHolder = ''
    export let id = ''
    export let label = ''
    export let type = 'text'
    export let className = null
    export let error
</script>

<div class={type === 'file' ? 'custom-file form-group mb-4' : 'form-group'}>
    {#if type === 'file'}
        <input bind:files type="file" class={'form-control ' + className} id={id} name={id}>
        <label for={id} class="custom-file-label">{label}</label>
    {:else}
        <label for={id}>{label}</label>
        <input value={value} on:input|preventDefault
               class={error ? ('form-control is-invalid ' + className) : ('form-control ' + className)} id={id} name={id}
               placeholder={placeHolder} type={type} />
        {#if error}
            <div class="invalid-feedback">
                The Field {id} {error.join(', ')}
            </div>
        {/if}
    {/if}
</div>