<script>
    import MenuItem from "./MenuItem.svelte";

    // Data
    let linksPost = [{label: 'Posts', link: '/posts'}, {label: 'Create Post', link: '/posts/new'}]
    let linksCategory = [{label: 'Categories', link: '/category'}, {label: 'Create Category', link: '/category/new'}]
</script>
<div class="sidebar">
    <div class="sidebar-inner">
        <ul>
            <li class="sidebar-title">CMS</li>
            <li>
                <a href="#" class="active">
                    <i class="fas fa-home icon-header-sidebar"></i>
                    Dashboard
                </a>
            </li>
            <li>
                <MenuItem name="Post" dataLinks={linksPost} icon="book"/>
            </li>
            <li>
                <MenuItem name="Category" dataLinks={linksCategory} icon="tags"/>
            </li>
        </ul>
    </div>
</div>