<script>
    import MenuItem from "./MenuItem.svelte";

    // Data
    let linksPost = [{label: 'Posts', link: '/admin/posts'}, {label: 'Create Post', link: '/admin/posts/new'}]
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
        </ul>
    </div>
</div>