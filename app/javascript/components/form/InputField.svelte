<script>
    export let value = ''
    export let files
    export let placeHolder = ''
    export let id = ''
    export let label = ''
    export let type = 'text'
    export let className = null
</script>

<div class={type === 'file' ? 'custom-file' : 'form-group'}>
    {#if type === 'file'}
        <input bind:files type="file" class={'form-control ' + className} id={id} name={id}>
        <label for={id} class="custom-file-label">{label}</label>
    {:else}
        <label for={id}>{label}</label>
        <input value={value} on:input|preventDefault class='form-control' id={id} name={id} placeholder={placeHolder}
               type="text"/>
    {/if}
</div>