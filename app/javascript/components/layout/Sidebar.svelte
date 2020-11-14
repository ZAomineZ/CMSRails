<script>
    import MenuItem from "./MenuItem.svelte";

    // Data
    let linksPost = [{label: 'Posts', link: '/admin/posts'}, {label: 'Create Post', link: '/admin/posts/new'}]
    let linksCategory = [{label: 'Categories', link: '/admin/category'}, {label: 'Create Category', link: '/admin/category/new'}]
</script>
<div class="sidebar">
    <div class="sidebar-inner">
        <ul>
            <li class="sidebar-title">CMS</li>
            <li>
                <a href="/admin" class="active">
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