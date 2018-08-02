# k8s-event-watcher
generic events watcher - intended to be used on PaaS k8s clusters where the master nodes are not controlled by the user / admin directly

The Dockerfile here is a (very) simple implementation of a way to expose Kubernetes `events` so they can be collected and shipped to a "longer-term" storage option (e.g. Elastic)  The pod created simply watches for events and logs to stdout by simple expedient of running a `kubectl get events --watch-only` in the foreground.  It is expected that another system, such as fluentd / beats / other will be running on the cluster to collect Pod logs and ship them appropriately.  If you need a more flexible, and or independent solution, I suggest taking a look at the excellent [eventrouter](https://github.com/heptiolabs/eventrouter) from heptiolabs 

The CMD line can obviously be configured with any options you want for the output e.g. you might want to add `-ojson` to present the event information in JSON format (though if you do, remember it's "pretty-printed" ;) ).  

Caveats... 
The pod needs to either: 
- be run in either kube-system
  or
- be granted appropriate priviliges to read `events` from the API
The logs are a bit RAW, so you'll likely want to grok / manipulate the output before shipping to your store of choice (unless you like relying on free-text search, ofc)

Usage:

The simplest way to put this in is just `kubectl run eventwatcher --image=[yourregistry]/eventwatcher:0.0.1`

(But I'd obviously recommend that you create a proper deployment for your environment and use VCS to manage/version it ;) )

