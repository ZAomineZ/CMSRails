<script>
    import ChevronLeft from "../Icons/ChevronLeft.svelte";
    import ChevronDown from "../Icons/ChevronDown.svelte";

    // Props
    export let name = ''
    export let icon = ''
    export let dataLinks = []

    // States
    let chevronOpen = false

    /**
     * @param {Event} e
     */
    function toggleMenu(e) {
        e.preventDefault()
        chevronOpen = !chevronOpen
    }
</script>

<a href="#" on:click={toggleMenu}>
    <i class="fas fa-{icon} icon-header-sidebar"></i>
    {name}
    {#if chevronOpen}
        <ChevronDown />
    {:else}
        <ChevronLeft />
    {/if}
</a>
<ul class="menu {chevronOpen ? 'active' : ''}">
    <li>
        {#each dataLinks as link}
            <a href="#">{link}</a>
        {/each}
    </li>
</ul>