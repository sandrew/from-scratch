cookbook_path    "cookbooks"
node_path        "tmp/nodes"
data_bag_path    "tmp/data_bags"

knife[:berkshelf_path] = "cookbooks"
Chef::Config[:ssl_verify_mode] = :verify_peer if defined? ::Chef
