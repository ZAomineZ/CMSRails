<script>
    import {onMount} from 'svelte';

    let navigation = false
    let body = null

    onMount(() => {
        body = document.querySelector('body')
    })

    /**
     * @param {Event} e
     */
    function toggleNavigation(e) {
        e.preventDefault()

        navigation = !navigation
        if (navigation) {
            body.classList.add('sidebar-show')
        } else {
            body.classList.remove('sidebar-show')
        }
    }
</script>


<div class="header">
    <nav class="navbar">
        <section class="navigation-header">
            <a class="button-collapse icon-navigation-header" href="#" on:click={toggleNavigation}>
                {#if navigation}
                    <span class="icon-navigation icon-navigation_to_arrow"></span>
                {:else}
                    <span class="icon-navigation icon-navigation_from_arrow"></span>
                {/if}
            </a>
        </section>
        <a class="navbar-brand" href="#">CMS</a>
        <button class="navbar-toggler">
            <i class="fas fa-angle-down"></i>
        </button>
        <div class="collapse navbar-collapse">
            <form action="#" id="search-header" class="form-inline my-2 mt-lg-0">
                <i class="fa fa-search icon-search-header"></i>
            </form>
        </div>
    </nav>
</div>