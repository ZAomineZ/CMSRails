<script>
    // Modules Svelte
    import { onMount } from 'svelte'

    import Header from "../layout/Header.svelte";
    import Sidebar from "../layout/Sidebar.svelte";
    import CategoriesTable from "./CategoriesTable.svelte";
    import BroadCast from "../layout/navigation/BroadCast.svelte";

    // Props
    export let categories = []
</script>

<Sidebar/>
<Header/>
<div class="container">
    <BroadCast content="Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ad esse minus quasi sequi! Culpa, distinctio dolore eum id, in ipsam iure nulla obcaecati odit repellat rerum sint soluta totam voluptates!"
               title="Categories"/>
    <CategoriesTable title="Categories List" categories={categories}/>
</div>