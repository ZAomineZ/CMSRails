<script>
    // MODULES SVELTE
    import {onMount} from 'svelte';

    // LIB
    import {Fetch} from "../../packs/helper/FetchApi";

    // MODULES HTML
    import AccountDetailsHeader from "./navigation/AccountDetailsHeader.svelte";
    import SearchItemsHeader from "./search/SearchItemsHeader.svelte"
    import ItemsResultsSearch from "./search/ItemsResultsSearch.svelte";

    // DATA
    let navigation = false
    let body = null
    let activeShow = false
    let activeResponsiveShow = false
    let valueInputSearch = ''
    let csrfValue = null

    let postsSearch = []

    onMount(() => {
        body = document.querySelector('body')
        csrfValue = document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    })

    // METHODS

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

    /**
     * @param {Event} event
     */
    async function handleInputItems(event) {
        if (!activeShow) {
            activeShow = !activeShow
        }
        if (valueInputSearch.length === 0) {
            activeShow = !activeShow
            return
        }
        const uri = '/search/' + valueInputSearch
        const response = await (new Fetch()).response(uri, 'POST', Fetch.FormDataCsrf(csrfValue))
        if (response.success) {
            const data = response.data
            postsSearch = data.posts
        }
    }

    const handleActiveClick = () => activeShow = !activeShow
    const handleActiveToggleClick = () => activeResponsiveShow = !activeResponsiveShow
</script>


<div class="header">
    <nav class="navbar navbar-expand-lg">
        <section class="navigation-header">
            <a class="button-collapse icon-navigation-header" href="#" on:click={toggleNavigation}>
                {#if navigation}
                    <span class="icon-navigation icon-navigation_to_arrow"></span>
                {:else}
                    <span class="icon-navigation icon-navigation_from_arrow"></span>
                {/if}
            </a>
        </section>
        <a class="navbar-brand" href="/admin">CMS</a>
        <button class="navbar-toggler" on:click|preventDefault={handleActiveToggleClick}>
            <i class="fas fa-angle-down"></i>
        </button>
        <div class={activeResponsiveShow ? 'collapse show navbar-collapse' : 'collapse navbar-collapse'}>
            <SearchItemsHeader bind:value={valueInputSearch} on:input={handleInputItems}/>
            <AccountDetailsHeader csrfValue={csrfValue}/>
        </div>
    </nav>
</div>
<ItemsResultsSearch activeShow={activeShow} items={{posts: postsSearch}}
                    on:click={handleActiveClick} valueInputSearch={valueInputSearch}/>