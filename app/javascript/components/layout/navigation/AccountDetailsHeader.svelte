<script>
    // Data
    let dropdown = false

    /**
     * @param {Event} event
     */
    function handleToggle(event) {
        dropdown = !dropdown
    }
</script>

<ul class="navbar-nav ml-auto">
    <li class="nav-item dropdown {dropdown ? 'show' : ''}">
        <a class="nav-link" href="#" on:click|preventDefault={handleToggle} role="button">
            <i class="fa fa-ellipsis-v"></i>
        </a>
        <ul class="dropdown-menu dropdown-menu-right">
            <li>
                <a class="dropdown-item" href="/account">Account</a>
            </li>
            <li class="divider"></li>
            <li>
                <a class="dropdown-item" href="#">Log Out</a>
            </li>
        </ul>
    </li>
</ul>