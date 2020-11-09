<script>
    export let value = ''
</script>

<form action="#" class="form-inline my-2 mt-lg-0" id="search-header">
    <input aria-label="Search" bind:value={value} class="form-control mr-sm-2"
           on:input|preventDefault
           placeholder="Search your posts, categories..." type="search">
</form>