<script>
    export let value = ''
    export let placeHolder = ''
    export let id = ''
    export let label = ''
    export let type = 'text'
    export let className = null
</script>

<div class={type === 'file' ? 'custom-file' : 'form-group'}>
    {#if type === 'file'}
        <input type="file" class={'form-control ' + className} id={id}>
        <label for={id} class="custom-file-label">{label}</label>
    {:else}
        <label for={id}>{label}</label>
        <input bind:value={value} class='form-control' id={id} name={id} placeholder={placeHolder}
               type="text"/>
    {/if}
</div>