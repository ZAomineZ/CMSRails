<script>
    import Header from "../layout/Header.svelte";
    import Sidebar from "../layout/Sidebar.svelte";
    import PostsTable from "./PostsTable.svelte";

    // Props
    export let posts = []
</script>

<Sidebar />
<Header />
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="title-page-contain">
                <nav>
                    <ol class="navigation">
                        <li class="navigation-item">
                            <a href="#">Home</a>
                        </li>
                        <li class="navigation-item active">
                            <i class="fas fa-chevron-right icon-navigation-item icon-navigation-item-m"></i>
                            Posts
                        </li>
                    </ol>
                </nav>
                <h3>Posts</h3>
                <p class="desc-page-contain">
                    Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ad esse minus quasi sequi! Culpa, distinctio dolore eum id, in ipsam iure nulla obcaecati odit repellat rerum sint soluta totam voluptates!
                </p>
            </div>
        </div>
    </div>
    <PostsTable title="Posts List" posts={posts}/>
</div>