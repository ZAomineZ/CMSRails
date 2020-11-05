<script>
    import MenuItem from "./MenuItem.svelte";

    // Data
    let linksPost = ['Posts', 'Create Post']
    let linksCategory = ['Categories', 'Create Category']
    let linksImage = ['Images', 'Create Image']
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
            <li>
                <MenuItem name="Image" dataLinks={linksImage} icon="images"/>
            </li>
        </ul>
    </div>
</div>